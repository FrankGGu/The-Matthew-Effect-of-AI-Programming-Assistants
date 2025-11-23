import pandas as pd

def filter_spam_messages(messages: pd.DataFrame) -> pd.DataFrame:
    spam_messages = messages[messages['spam'] == True]
    return spam_messages