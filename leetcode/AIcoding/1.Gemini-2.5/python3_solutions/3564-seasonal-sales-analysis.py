import pandas as pd

def seasonal_sales_analysis(sales: pd.DataFrame, product: pd.DataFrame) -> pd.DataFrame:
    sales['sale_date'] = pd.to_datetime(sales['sale_date'])

    q1_2019_start = pd.to_datetime('2019-01-01')
    q1_2019_end = pd.to_datetime('2019-03-31')

    filtered_sales = sales[
        (sales['sale_date'] >= q1_2019_start) & 
        (sales['sale_date'] <= q1_2019_end)
    ]

    products_in_q1 = filtered_sales['product_id'].unique()

    result = product[product['product_id'].isin(products_in_q1)]

    return result[['product_id', 'product_name']].sort_values(by='product_id').reset_index(drop=True)