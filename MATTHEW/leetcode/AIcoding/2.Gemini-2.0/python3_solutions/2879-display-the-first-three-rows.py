import pandas as pd

def display_top_three(customers: pd.DataFrame) -> pd.DataFrame:
    return customers.head(3)