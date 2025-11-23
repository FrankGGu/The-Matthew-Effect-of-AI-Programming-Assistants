import pandas as pd

def find_books(books: pd.DataFrame, orders: pd.DataFrame) -> pd.DataFrame:
    merged = pd.merge(orders, books, on='book_id', how='inner')
    grouped = merged.groupby('book_id')['quantity'].sum().reset_index()
    result = grouped[grouped['quantity'] > grouped.available]['book_id'].to_frame()
    return result