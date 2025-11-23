import pandas as pd

def seasonal_sales_analysis(sales: pd.DataFrame) -> pd.DataFrame:
    sales['month'] = sales['date'].dt.month
    sales['season'] = sales['month'].apply(
        lambda x: 'Spring' if 3 <= x <= 5 else
                  'Summer' if 6 <= x <= 8 else
                  'Fall' if 9 <= x <= 11 else
                  'Winter'
    )
    result = sales.groupby(['product_id', 'season']).agg(
        total_sales=('quantity', 'sum')
    ).reset_index()
    result = result.sort_values(['product_id', 'total_sales', 'season'], ascending=[True, False, True])
    result = result.groupby('product_id').first().reset_index()
    return result[['product_id', 'season', 'total_sales']]