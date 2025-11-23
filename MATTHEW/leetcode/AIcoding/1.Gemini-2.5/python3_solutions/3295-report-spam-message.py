import pandas as pd

def reportSpamMessages(messages: pd.DataFrame) -> pd.DataFrame:
    spam_messages = messages[messages['spam_flag'] == 1]
    result = spam_messages[['message_id']]
    return result