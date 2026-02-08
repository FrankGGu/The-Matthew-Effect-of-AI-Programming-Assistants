class Solution:
    def maximizeNumberofSubsequences(self, text: str, pattern: str) -> int:
        p0 = pattern[0]
        p1 = pattern[1]

        current_p0_count = 0
        original_subsequences = 0
        total_p0_in_text = 0
        total_p1_in_text = 0

        for char in text:
            if char == p1:
                original_subsequences += current_p0_count
                total_p1_in_text += 1
            if char == p0:
                current_p0_count += 1
                total_p0_in_text += 1

        ans1 = original_subsequences + total_p1_in_text
        ans2 = original_subsequences + total_p0_in_text

        return max(ans1, ans2)