class Solution:
    def happyStudents(self, scores: list[int]) -> int:
        n = len(scores)
        scores.sort()

        happy_ways = 0

        # Case 1: All students are called (k = n)
        # If all n students are called, for them to be happy, their scores must be strictly greater than n.
        # Since scores is sorted, this means the smallest score (scores[0]) must be > n.
        if scores[0] > n:
            happy_ways += 1

        # Case 2: Some students are called, some are not (0 < k < n)
        # Let 'i' be the number of students NOT called.
        # Then 'k = n - i' is the number of students ARE called.
        # To satisfy the happiness conditions for all students, we must choose:
        # - The 'i' students with the lowest scores (scores[0]...scores[i-1]) to be NOT called.
        # - The 'k' students with the highest scores (scores[i]...scores[n-1]) to be called.
        #
        # Conditions for this partition to be valid:
        # 1. For the 'i' not-called students to be happy:
        #    Their scores must be strictly less than or equal to 'k'.
        #    This implies scores[i-1] <= k (i.e., scores[i-1] <= n - i).
        # 2. For the 'k' called students to be happy:
        #    Their scores must be strictly greater than 'k'.
        #    This implies scores[i] > k (i.e., scores[i] > n - i).
        #
        # We iterate 'i' from 1 to n-1 (inclusive).
        for i in range(1, n):
            k = n - i
            if scores[i-1] <= k and scores[i] > k:
                happy_ways += 1

        # Case 3: No students are called (k = 0)
        # If 0 students are called, all n students are NOT called.
        # For them to be happy, their scores must be strictly less than or equal to 0.
        # However, the problem constraints state that 1 <= scores[j] for all students.
        # Therefore, this condition (scores[j] <= 0) can never be met.
        # So, k=0 is never a valid choice, and we do not add to happy_ways for this case.

        return happy_ways