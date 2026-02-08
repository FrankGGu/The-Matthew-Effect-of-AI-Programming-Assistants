import pandas as pd

class Solution:
    def categorize_transactions(self, transactions: pd.DataFrame) -> pd.DataFrame:
        transactions['category'] = transactions['amount'].apply(lambda x: 'Even' if x % 2 == 0 else 'Odd')

        grouped_sums = transactions.groupby('category')['amount'].sum()

        final_sums = grouped_sums.reindex(['Even', 'Odd'], fill_value=0)

        final_df = final_sums.reset_index()
        final_df.columns = ['category', 'total_amount']

        return final_df