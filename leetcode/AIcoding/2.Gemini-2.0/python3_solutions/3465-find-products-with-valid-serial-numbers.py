import pandas as pd

def find_products(products: pd.DataFrame, purchases: pd.DataFrame) -> pd.DataFrame:
    merged_df = pd.merge(products, purchases, left_on='product_id', right_on='product_id')
    valid_products = merged_df[merged_df['quantity'] > 0]['product_id'].unique()
    result_df = products[products['product_id'].isin(valid_products)][['product_name']]
    return result_df