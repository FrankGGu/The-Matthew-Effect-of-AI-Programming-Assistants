import pandas as pd

def analyze_subscription_conversion(activities: pd.DataFrame) -> pd.DataFrame:
    """
    Calculates the conversion rate of users who subscribed at least once.

    Args:
        activities (pd.DataFrame): A DataFrame with user activities,
                                   expected to have 'user_id' and 'activity_type' columns.

    Returns:
        pd.DataFrame: A DataFrame with a single row and a single column 'conversion_rate',
                      representing the percentage of unique users who subscribed.
    """
    # Find the number of unique users who performed a 'subscribe' activity
    subscribed_users_count = activities[activities['activity_type'] == 'subscribe']['user_id'].nunique()

    # Find the total number of unique users in the activities DataFrame
    total_users_count = activities['user_id'].nunique()

    # Calculate the conversion rate
    if total_users_count == 0:
        conversion_rate = 0.0
    else:
        conversion_rate = subscribed_users_count / total_users_count

    # Create a DataFrame for the result with the required column name
    result_df = pd.DataFrame({'conversion_rate': [conversion_rate]})

    return result_df