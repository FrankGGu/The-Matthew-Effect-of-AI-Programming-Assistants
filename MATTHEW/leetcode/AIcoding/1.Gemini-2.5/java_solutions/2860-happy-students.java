import java.util.Arrays;

class Solution {
    public int happyStudents(int[] nums) {
        Arrays.sort(nums);
        int n = nums.length;
        int happyWays = 0;

        // Case 1: Choose 0 students
        // All n students are unchosen. For them to be "not happy" with 0 chosen students,
        // we need 0 <= nums[i] for all i. This is always true as nums[i] >= 0.
        happyWays++;

        // Case 2: Choose k students, where 1 <= k <= n
        for (int k = 1; k <= n; k++) {
            // Condition for chosen students:
            // The k chosen students (nums[0]...nums[k-1]) must all be happy.
            // This means k > nums[i] for all i from 0 to k-1.
            // Since nums is sorted, this simplifies to k > nums[k-1].
            boolean chosenStudentsHappy = (k > nums[k - 1]);

            // Condition for unchosen students:
            // The n-k unchosen students (nums[k]...nums[n-1]) must all be not happy.
            // This means k <= nums[j] for all j from k to n-1.
            // Since nums is sorted, this simplifies to k <= nums[k].
            // This condition only applies if there are unchosen students (i.e., k < n).
            boolean unchosenStudentsNotHappy;
            if (k < n) {
                unchosenStudentsNotHappy = (k <= nums[k]);
            } else {
                // If k == n, all students are chosen, so there are no unchosen students.
                // This condition is vacuously true.
                unchosenStudentsNotHappy = true;
            }

            if (chosenStudentsHappy && unchosenStudentsNotHappy) {
                happyWays++;
            }
        }

        return happyWays;
    }
}