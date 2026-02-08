class Solution:
    def dropMissingData(self, df: List[List[Optional[int]]]) -> List[List[Optional[int]]]:
        return [row for row in df if None not in row]