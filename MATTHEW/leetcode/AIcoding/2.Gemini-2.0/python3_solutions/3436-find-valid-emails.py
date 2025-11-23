import re
import pandas as pd

def valid_emails(emails: pd.DataFrame) -> pd.DataFrame:
    pattern = r'^[a-zA-Z][a-zA-Z0-9._-]*@leetcode\.com$'
    emails['valid'] = emails['email'].apply(lambda x: bool(re.match(pattern, x)))
    return emails[emails['valid'] == True][['email']]