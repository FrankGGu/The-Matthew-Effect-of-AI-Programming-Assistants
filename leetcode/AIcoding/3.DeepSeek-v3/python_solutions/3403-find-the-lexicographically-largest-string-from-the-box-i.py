class Solution:
    def largestStringFromBox(self, box: List[str]) -> str:
        max_str = ""
        for s in box:
            if len(s) > len(max_str) or (len(s) == len(max_str) and s > max_str):
                max_str = s
        return max_str