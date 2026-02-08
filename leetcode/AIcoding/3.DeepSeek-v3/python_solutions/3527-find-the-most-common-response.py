import pandas as pd

def most_common_response(df: pd.DataFrame) -> pd.DataFrame:
    # Group by user_id and question, then find the most common response for each group
    result = df.groupby(['user_id', 'question'])['answer'].agg(lambda x: x.mode()[0]).reset_index()
    return result