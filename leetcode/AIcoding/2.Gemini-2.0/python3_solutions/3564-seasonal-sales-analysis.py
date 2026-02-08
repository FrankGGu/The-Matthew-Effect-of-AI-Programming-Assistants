import pandas as pd

def seasonal_sales(sales: pd.DataFrame) -> pd.DataFrame:
    sales['month'] = pd.to_datetime(sales['purchase_date']).dt.month
    winter_sales = sales[sales['month'].isin([12, 1, 2])]
    spring_sales = sales[sales['month'].isin([3, 4, 5])]
    summer_sales = sales[sales['month'].isin([6, 7, 8])]
    autumn_sales = sales[sales['month'].isin([9, 10, 11])]

    winter_total = winter_sales['amount'].sum()
    spring_total = spring_sales['amount'].sum()
    summer_total = summer_sales['amount'].sum()
    autumn_total = autumn_sales['amount'].sum()

    data = {'season': ['Spring', 'Summer', 'Autumn', 'Winter'],
            'total_amount': [spring_total, summer_total, autumn_total, winter_total]}

    result = pd.DataFrame(data)
    return result