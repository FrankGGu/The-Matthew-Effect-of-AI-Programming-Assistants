class Solution:
    def renameColumns(self, columns: List[str], mapping: List[str]) -> List[str]:
        return [mapping[columns.index(col)] for col in columns]