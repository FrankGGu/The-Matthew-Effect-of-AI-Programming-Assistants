class Solution:
    def maximumLength(self, nums: List[str]) -> int:
        def is_good(subseq):
            return len(set(''.join(subseq))) == sum(len(s) for s in subseq)

        def backtrack(start, subseq):
            if start == len(nums):
                return len(''.join(subseq)) if is_good(subseq) else 0
            return max(backtrack(start + 1, subseq), backtrack(start + 1, subseq + [nums[start]]))

        return backtrack(0, [])