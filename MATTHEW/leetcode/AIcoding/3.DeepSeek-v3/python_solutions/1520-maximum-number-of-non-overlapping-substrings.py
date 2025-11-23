class Solution:
    def maxNumOfSubstrings(self, s: str) -> List[str]:
        first = {c: i for i, c in reversed(list(enumerate(s)))}
        last = {c: i for i, c in enumerate(s)}

        intervals = []
        for c in set(s):
            start, end = first[c], last[c]
            i = start
            while i <= end:
                if first[s[i]] < start:
                    start = first[s[i]]
                if last[s[i]] > end:
                    end = last[s[i]]
                i += 1
            i = start
            while i <= end:
                if first[s[i]] < start or last[s[i]] > end:
                    start, end = -1, -1
                    break
                i += 1
            if start != -1:
                intervals.append((start, end))

        intervals.sort(key=lambda x: x[1])
        res = []
        prev_end = -1
        for start, end in intervals:
            if start > prev_end:
                res.append(s[start:end+1])
                prev_end = end
        return res