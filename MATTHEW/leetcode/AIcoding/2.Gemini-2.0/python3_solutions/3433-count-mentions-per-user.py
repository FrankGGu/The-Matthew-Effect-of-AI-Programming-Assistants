import pandas as pd

def count_mentions(emails: pd.DataFrame, mentions: pd.DataFrame) -> pd.DataFrame:
    merged_df = pd.merge(emails, mentions, left_on='id', right_on='email_id', how='inner')
    grouped_df = merged_df.groupby('recipient')['mention_cnt'].sum().reset_index()
    grouped_df.rename(columns={'recipient': 'user', 'mention_cnt': 'mentions_count'}, inplace=True)
    return grouped_df