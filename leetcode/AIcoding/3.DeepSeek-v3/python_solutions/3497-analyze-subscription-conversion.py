import pandas as pd

def analyze_subscription_conversion(visits: pd.DataFrame, subscriptions: pd.DataFrame) -> pd.DataFrame:
    # Merge visits and subscriptions on user_id and visit_date
    merged = pd.merge(visits, subscriptions, on=['user_id', 'visit_date'], how='left')

    # Calculate the total visits per date
    total_visits = visits.groupby('visit_date').size().reset_index(name='total_visits')

    # Calculate the number of subscriptions per date
    subscriptions_count = subscriptions.groupby('visit_date').size().reset_index(name='subscriptions')

    # Merge total_visits and subscriptions_count
    result = pd.merge(total_visits, subscriptions_count, on='visit_date', how='left')

    # Fill NaN with 0 for dates with no subscriptions
    result['subscriptions'] = result['subscriptions'].fillna(0)

    # Calculate conversion rate
    result['conversion_rate'] = (result['subscriptions'] / result['total_visits']).round(2)

    # Select and return the required columns
    return result[['visit_date', 'conversion_rate']]