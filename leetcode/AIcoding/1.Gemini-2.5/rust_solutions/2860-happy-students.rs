impl Solution {
    pub fn happy_students(satisfaction: Vec<i32>) -> i32 {
        let mut s = satisfaction;
        s.sort_unstable();
        let n = s.len();
        let mut ways = 0;

        // Case k = 0: No students selected.
        // All 'n' students are unselected.
        // For an unselected student 'j', the condition is 0 <= satisfaction[j].
        // Since all satisfaction levels are non-negative, this is always true.
        ways += 1;

        // Cases 0 < k < n: 'k' students selected, 'n-k' students unselected.
        // To satisfy the conditions, we must select the 'k' students with the lowest
        // satisfaction values (s[0]...s[k-1]) and leave the rest (s[k]...s[n-1]) unselected.
        // Conditions:
        // 1. All 'k' selected students are happy: k > s[i] for i in [0, k-1].
        //    This simplifies to k > s[k-1] (since s is sorted).
        // 2. All 'n-k' unselected students are unhappy: k <= s[j] for j in [k, n-1].
        //    This simplifies to k <= s[k] (since s is sorted).
        for k in 1..n {
            if (k as i32) > s[k - 1] && (k as i32) <= s[k] {
                ways += 1;
            }
        }

        // Case k = n: All 'n' students selected.
        // All 'n' students are selected.
        // For a selected student 'i', the condition is n > satisfaction[i].
        // This simplifies to n > s[n-1] (since s is sorted).
        if (n as i32) > s[n - 1] {
            ways += 1;
        }

        ways
    }
}