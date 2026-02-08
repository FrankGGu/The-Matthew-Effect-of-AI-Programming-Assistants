class Solution:
    def createNewColumn(self, df: pd.DataFrame) -> pd.DataFrame:
        df['new_column'] = df['column1'] + df['column2']
        return df