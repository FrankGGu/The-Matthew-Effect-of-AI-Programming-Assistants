import pandas as pd

def fillMissingData(products: pd.DataFrame) -> pd.DataFrame:
    mean_price = products['price'].mean()
    products['price'] = products['price'].fillna(mean_price)
    return products