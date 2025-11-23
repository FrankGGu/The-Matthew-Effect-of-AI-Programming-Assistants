from datetime import datetime
import pandas as pd

def sales_analysis(sales: pd.DataFrame, product: pd.DataFrame) -> pd.DataFrame:
    sales['sale_date'] = pd.to_datetime(sales['sale_date'])
    min_date = sales['sale_date'].min()
    max_date = sales['sale_date'].max()

    winter = (sales['sale_date'] >= min_date) & (sales['sale_date'] <= '2020-02-29')
    spring = (sales['sale_date'] >= '2020-03-01') & (sales['sale_date'] <= '2020-05-31')
    summer = (sales['sale_date'] >= '2020-06-01') & (sales['sale_date'] <= '2020-08-31')
    autumn = (sales['sale_date'] >= '2020-09-01') & (sales['sale_date'] <= '2020-11-30')

    winter_sales = sales[winter]
    spring_sales = sales[spring]
    summer_sales = sales[summer]
    autumn_sales = sales[autumn]

    winter_total = winter_sales['price'].sum()
    spring_total = spring_sales['price'].sum()
    summer_total = summer_sales['price'].sum()
    autumn_total = autumn_sales['price'].sum()

    result = {
        'season': ['Winter', 'Spring', 'Summer', 'Autumn'],
        'total_sales': [winter_total, spring_total, summer_total, autumn_total]
    }

    return pd.DataFrame(result)