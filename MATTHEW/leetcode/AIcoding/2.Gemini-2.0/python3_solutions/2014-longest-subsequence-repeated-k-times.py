class Solution:
    def longestSubsequenceRepeatedK(self, s: str, k: int) -> str:
        count = {}
        for char in s:
            count[char] = count.get(char, 0) + 1

        chars = [char for char in count if count[char] >= k]
        chars.sort()

        res = ""

        def isValid(subsequence):
            idx = 0
            count = 0
            for char in s:
                if idx < len(subsequence) and char == subsequence[idx]:
                    idx += 1
                    if idx == len(subsequence):
                        count += 1
                        idx = 0
            return count >= k

        q = [""]

        longest = ""

        while q:
            curr = q.pop(0)

            for char in chars:
                new_sub = curr + char
                if isValid(new_sub):
                    longest = new_sub
                    q.append(new_sub)

        return longest