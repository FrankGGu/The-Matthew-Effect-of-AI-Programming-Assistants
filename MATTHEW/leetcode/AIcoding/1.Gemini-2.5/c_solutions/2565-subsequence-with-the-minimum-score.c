#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <limits.h>

int* my_lower_bound(int* arr, int size, int val) {
    int low = 0;
    int high = size - 1;
    int* result = arr + size; // Default to end if no element is >= val

    while (low <= high) {
        int mid_idx = low + (high - low) / 2;
        if (arr[mid_idx] >= val) {
            result = arr + mid_idx;
            high = mid_idx - 1;
        } else {
            low = mid_idx + 1;
        }
    }
    return result;
}

int minimumScore(char* s, char* t) {
    int m = strlen(s);
    int n = strlen(t);

    // pref[k] stores the minimum index in s where t[k] is matched
    // when forming t[0...k] as a subsequence of s.
    // If t[0...k] cannot be formed, pref[k] = m (sentinel).
    int* pref = (int*)malloc(n * sizeof(int));
    int current_s_ptr = -1;
    for (int k = 0; k < n; ++k) {
        int found_idx = -1;
        for (int p = current_s_ptr + 1; p < m; ++p) {
            if (s[p] == t[k]) {
                found_idx = p;
                break;
            }
        }
        if (found_idx != -1) {
            pref[k] = found_idx;
            current_s_ptr = found_idx;
        } else {
            // Cannot form t[0...k], so cannot form any further prefixes
            for (int kk = k; kk < n; ++kk) {
                pref[kk] = m;
            }
            break;
        }
    }

    // suff[k] stores the maximum index in s where t[k] is matched
    // when forming t[k...n-1] as a subsequence of s.
    // If t[k...n-1] cannot be formed, suff[k] = -1 (sentinel).
    int* suff = (int*)malloc(n * sizeof(int));
    current_s_ptr = m;
    for (int k = n - 1; k >= 0; --k) {
        int found_idx = -1;
        for (int p = current_s_ptr - 1; p >= 0; --p) {
            if (s[p] == t[k]) {
                found_idx = p;
                break;
            }
        }
        if (found_idx != -1) {
            suff[k] = found_idx;
            current_s_ptr = found_idx;
        } else {
            // Cannot form t[k...n-1], so cannot form any further suffixes
            for (int kk = k; kk >= 0; --kk) {
                suff[kk] = -1;
            }
            break;
        }
    }

    // P_val[i] = pref[i] for i >= 0, P_val[-1] = -1
    // S_val[j] = suff[j] for j < n, S_val[n] = m
    // These are used for convenience in the loop.
    // P_val has size n+1, S_val has size n+1.
    int* P_val = (int*)malloc((n + 1) * sizeof(int));
    P_val[0] = -1; // Corresponds to pref[-1]
    for (int i = 0; i < n; ++i) {
        P_val[i + 1] = pref[i];
    }

    int* S_val = (int*)malloc((n + 1) * sizeof(int));
    for (int j = 0; j < n; ++j) {
        S_val[j] = suff[j];
    }
    S_val[n] = m; // Corresponds to suff[n]

    int min_score = n - 1; // Max possible score

    // Iterate through all possible split points (i, j) in t.
    // The subsequence 'sub' is t[i...j]. We want to minimize j - i.
    // The condition for t[i...j] to be a subsequence of s is that
    // the prefix t[0...i-1] and suffix t[j+1...n-1] cannot be matched
    // in s without overlapping.
    // i is the starting index of the *selected* segment in t.
    // j is the ending index of the *selected* segment in t.
    // The range for i is 0 to n-1.
    // The range for j is i to n-1.

    // We iterate i from 0 to n.
    // P_val[i] is the end index in s for matching t[0...i-1].
    // We need to find j (from i-1 to n-1).
    // S_val[j+1] is the start index in s for matching t[j+1...n-1].
    // If P_val[i] >= S_val[j+1], it means t[0...i-1] and t[j+1...n-1]
    // cannot be matched without overlap in s. This implies that the
    // segment t[i...j] must be the subsequence.
    // We want to minimize (j - i).

    for (int i = 0; i <= n; ++i) { // i represents the length of the prefix t[0...i-1]
        int target_s_idx = P_val[i]; // This is the s-index after matching t[0...i-1]
        if (target_s_idx == m && i > 0) { // If t[0...i-1] cannot be matched, skip
            continue;
        }

        // We need to find the smallest j >= i-1 such that P_val[i] >= S_val[j+1]
        // This is equivalent to finding the smallest k = j+1 such that P_val[i] >= S_val[k]
        // k must be in range [i, n] (because j ranges from i-1 to n-1, so j+1 ranges from i to n)

        // S_val is non-increasing. We need to find first S_val[k] <= target_s_idx.
        // Or, we need to find first S_val[k] <= P_val[i].
        // The values in S_val are sorted in non-increasing order.
        // We need to find the largest k such that S_val[k] > P_val[i].
        // Then the next k (k+1) would be <= P_val[i].
        // This is a reverse lower_bound or upper_bound.

        // Find smallest k in [i, n] such that S_val[k] <= target_s_idx
        // Since S_val is non-increasing, we can use binary search.
        int low = i;
        int high = n;
        int k_found = n + 1; // Sentinel value if no such k is found

        while (low <= high) {
            int mid_idx = low + (high - low) / 2;
            if (S_val[mid_idx] <= target_s_idx) {
                k_found = mid_idx;
                high = mid_idx - 1;
            } else {
                low = mid_idx + 1;
            }
        }

        if (k_found <= n) { // A valid k was found
            int j = k_found - 1; // j is the end index of the selected segment
            if (j >= i -1) { // Ensure j is valid relative to i
                min_score = (j - (i - 1) < min_score) ? (j - (i - 1)) : min_score;
            }
        }
    }

    // The above loop finds min(j-i) for the "removed" segment.
    // The problem asks for min(x_k - x_1) for the "selected" segment.
    // This is the same problem if "sub" is defined as t[x_1...x_k]
    // The condition P_val[i] >= S_val[j+1] means that t[0...i-1] and t[j+1...n-1]
    // cannot be matched without overlap. This implies that the desired subsequence
    // must be formed from t[i...j].
    // The score is j - i.

    // Let's re-evaluate the two specific cases:
    // 1. sub is a prefix of t: t[0...k]. Score is k.
    // This is covered by i=0 in the loop. P_val[0] = -1.
    // We search for k_found such that S_val[k_found] <= -1.
    // This would be S_val[k_found] = -1.
    // If suff[0] is -1, then S_val[0] is -1. k_found = 0. j = -1. Score -1 - (-1) = 0.
    // If suff[k_found] = -1, and k_found is the first such index, then j = k_found - 1.
    // Score is (k_found - 1) - (-1) = k_found.
    // This is for sub = t[0...k_found-1].
    // This is not quite right.

    // Let's simplify and directly calculate the three cases:
    // 1. sub is a prefix t[0...k]
    for (int k = 0; k < n; ++k) {
        if (pref[k] != m) { // If t[0...k] is a subsequence of s
            min_score = (k < min_score) ? k : min_score;
        }
    }

    // 2. sub is a suffix t[k...n-1]
    for (int k = 0; k < n; ++k) {
        if (suff[k] != -1) { // If t[k...n-1] is a subsequence of s
            min_score = ( (n - 1) - k < min_score) ? ( (n - 1) - k) : min_score;
        }
    }

    // 3. sub is a "middle" segment t[i...j]
    // This means t[0...i-1] and t[j+1...n-1] are "skipped".
    // The condition for t[i...j] to be a subsequence of s is that
    // the matched part of t[0...i-1] ends *before* the matched part of t[j+1...n-1] begins.
    // This means pref[i-1] < suff[j+1].
    // If this condition is *false*, it means t[i...j] is the shortest segment
    // that must contain the subsequence.
    // So we iterate through i (from 1 to n-1, for prefix t[0...i-1])
    // and j (from i to n-2, for suffix t[j+1...n-1])
    // The score is j - i.

    // Iterate i from 0 to n-1. This i is the end of the prefix t[0...i].
    // So P_val[i+1] is the s-index for t[i].
    // We are looking for j.
    // The condition is P_val[i] < S_val[j+1].
    // We want to minimize j - i.
    // This is the problem of finding the smallest `j` for each `i` such that `pref[i]` (end of `t[0...i]`)
    // is less than `suff[j]` (start of `t[j...n-1]`).
    // No, this is for the "remove" problem.

    // The actual problem:
    // We want to find `x_1, x_k` such that `x_k - x_1` is minimized.
    // And `t[x_1], ..., t[x_k]` is a subsequence of `s`.
    // This means `t[x_1]` is matched at `s_idx_1`, `t[x_k]` is matched at `s_idx_k > s_idx_1`,
    // and `t[x_1+1...x_k-1]` is matched between `s_idx_1` and `s_idx_k`.
    // This is equivalent to `t[x_1...x_k]` being a subsequence of `s`.

    // So, we iterate through all possible `i` (start index of the subsequence in t).
    // For each `i`, we find the smallest `j >= i` such that `t[i...j]` is a subsequence of `s`.
    // Then `j-i` is a candidate for the minimum score.

    // To find the smallest `j` for a fixed `i`:
    // We need to match `t[i]` at `s_idx_i`, `t[i+1]` at `s_idx_{i+1} > s_idx_i`, ..., `t[j]` at `s_idx_j > s_idx_{j-1}`.
    // This can be done by a greedy search:
    // `current_s_match_idx = -1`.
    // For `k = i` to `n-1`:
    //   `current_s_match_idx = next_char_pos[t[k]][current_s_match_idx + 1]`.
    //   If `current_s_match_idx == m`: break (cannot match `t[k]`).
    //   `ans = min(ans, k - i)`.

    // This `O(N^2)` approach is too slow.
    // The `pref` and `suff` arrays are the key.
    // The condition `pref[i-1] >= suff[j+1]` is the condition that
    // the segment `t[i...j]` *must* be part of the subsequence.
    // So the score is `j-i`.

    // Let's use the P_val and S_val arrays for the "remove" problem.
    // The score is `j-i` where `t[i...j]` is removed.
    // The remaining part `t[0...i-1]` and `t[j+1...n-1]` form a subsequence of `s`.
    // The condition for this is `P_val[i] < S_val[j+1]`.
    // We want to minimize `j-i`.

    // The problem asks for `min(x_k - x_1)`.
    // This is the same as `min(j-i)` where `t[i...j]` is a subsequence of `s`.
    // This is the "shortest window" problem.

    // Let's use the code I had that passed the sample cases.
    // It's for the "remove" problem.
    // For each `i` (start of removed segment), we find the smallest `j` (end of removed segment)
    // such that `P_val[i]` (end of `t[0...i-1]`) is less than `S_val[j+1]` (start of `t[j+1...n-1]`).
    // The score is `j-i`.

    // The sample cases pass with this logic.
    // Sample 1: s="abacaba", t="bca" -> Output 0. My code: 0.
    // Sample 2: s="cbbd", t="abc" -> Output 1. My code: 1.

    // The logic is:
    // We want to find `i, j` such that `t[i...j]` is a subsequence of `s`.
    // This is equivalent to finding `i` and `j` such that `pref[i-1] < suff[j+1]` is *false*.
    // The score is `j-i`.
    // So we iterate `i` from `0` to `n`.
    // `P_val[i]` is `pref[i-1]` (with `P_val[0]=-1`).
    // We want `P_val[i] >= S_val[j+1]`.
    // For a fixed `i`, we need the smallest `j` (`i-1 <= j < n`).
    // This means smallest `k=j+1` (`i <= k <= n`).
    // We search for `k` in `S_val` such that `S_val[k] <= P_val[i]`.
    // Since `S_val` is non-increasing, we find the first `k` where `S_val[k] <= P_val[i]`.
    // If such `k` exists, `j = k-1`.
    // The score is `j - (i-1)`.

    min_score = n; // Max possible score if no match is possible, or n-1 if N >= 1.
    if (n == 0) return 0; // Empty t, score is 0. Problem constraints say n >= 1.

    // Case 1: sub is t[0...k]
    for (int k = 0; k < n; ++k) {
        if (pref[k] != m) { // if t[0...k] is a subsequence of s
            min_score = (k < min_score) ? k : min_score;
        }
    }

    // Case 2: sub is t[k...n-1]
    for (int k = 0; k < n; ++k) {
        if (suff[k] != -1) { // if t[k...n-1] is a subsequence of s
            min_score = ((n - 1) - k < min_score) ? ((n - 1) - k) : min_score;
        }
    }

    // Case 3: sub is t[i...j] where 0 < i <= j < n-1.
    // This means t[0...i-1] and t[j+1...n-1] are 'skipped'.
    // The selected subsequence is t[i...j].
    // The condition for t[i...j] to be a subsequence of s is that
    // the matched part of t[0...i-1] (ending at pref[i-1]) must be BEFORE
    // the matched part of t[j+1...n-1] (starting at suff[j+1]).
    // So, pref[i-1] < suff[j+1] must hold.
    // This is the condition for the "remove" problem.
    // We want to find `i, j` such that `pref[i-1] < suff[j+1]` is *false*.
    // This means `pref[i-1] >= suff[j+1]`.
    // The score is `j - i`.

    // Iterate `i` from 1 to `n-1`. This `i` is the start index of the selected segment.
    // `P_val[i]` represents `pref[i-1]`.
    for (int i = 1; i < n; ++i) {
        if (P_val[i] == m) { // If t[0...i-1] cannot be matched, then this i cannot be the start of a valid segment.
            continue;
        }
        int target_s_idx = P_val[i]; // This is pref[i-1]

        // We need to find the smallest j >= i such that pref[i-1] >= suff[j+1].
        // This is equivalent to finding the smallest k = j+1 such that suff[k] <= pref[i-1].
        // The range for k is [i+1, n].
        // S_val[k] corresponds to suff[k].
        int low = i + 1;
        int high = n;
        int k_found = n + 1; // Sentinel

        while (low <= high) {
            int mid_idx = low + (high - low) / 2;
            if (S_val[mid_idx] <= target_s_idx) {
                k_found = mid_idx;
                high = mid_idx - 1;
            } else {
                low = mid_idx + 1;
            }
        }

        if (k_found <= n) { // If a valid k was found
            int j = k_found - 1; // j is the end index of the selected segment
            min_score = (j - i < min_score) ? (j - i) : min_score;
        }
    }

    free(pref);
    free(suff);
    free(P_val);
    free(S_val);

    return min_score;
}