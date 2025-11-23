class Solution:
    def maxNumOfSubstrings(self, s: str) -> List[str]:
        last = {c: i for i, c in enumerate(s)}
        intervals = []

        for i in range(len(s)):
            if i == last[s[i]]:
                intervals.append((i, i))
            else:
                left = i
                right = last[s[i]]
                while left < right:
                    right = max(right, last[s[right]])
                    left += 1
                intervals.append((i, right))

        intervals.sort(key=lambda x: (x[1], x[0]))
        res = []
        end = -1

        for start, finish in intervals:
            if start >= end:
                res.append(s[start:finish + 1])
                end = finish

        return res