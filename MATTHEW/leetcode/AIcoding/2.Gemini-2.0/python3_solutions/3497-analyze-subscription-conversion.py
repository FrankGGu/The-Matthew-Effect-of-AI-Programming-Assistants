import pandas as pd

def analyze_subscriptions(subscriptions: pd.DataFrame, sessions: pd.DataFrame) -> pd.DataFrame:
    df = pd.merge(sessions, subscriptions, left_on='account_id', right_on='account_id', how='left')
    df_sub = df[df['subscription_start'] <= df['session_start']]
    df_sub = df_sub[df_sub['subscription_end'] >= df_sub['session_start']]

    converted = df_sub['account_id'].nunique()
    total = subscriptions['account_id'].nunique()

    conversion_rate = 0.0
    if total > 0:
        conversion_rate = round((converted / total) * 100, 2)

    result = pd.DataFrame({'conversion_rate': [conversion_rate]})
    return result