class Solution:
    def getSize(self, df: List[List[int]]) -> List[int]:
        return [len(df), len(df[0])] if df else [0, 0]