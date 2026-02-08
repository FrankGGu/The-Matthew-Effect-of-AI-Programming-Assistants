int maximumConsecutive(int* A, int ASize, int K) {
    int left = 0, right = 0, max_count = 0, count = 0;
    int freq[100001] = {0};

    while (right < ASize) {
        freq[A[right]]++;
        count = freq[A[right]] > 0 ? count + 1 : count;

        while (right - left + 1 - count > K) {
            freq[A[left]]--;
            if (freq[A[left]] == 0) count--;
            left++;
        }

        max_count = max_count > right - left + 1 ? max_count : right - left + 1;
        right++;
    }

    return max_count;
}