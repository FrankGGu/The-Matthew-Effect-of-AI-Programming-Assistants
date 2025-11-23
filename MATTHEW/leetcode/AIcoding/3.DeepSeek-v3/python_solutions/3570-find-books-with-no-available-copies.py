import pandas as pd

def find_books(books: pd.DataFrame, orders: pd.DataFrame) -> pd.DataFrame:
    # Merge books and orders to find books with orders
    merged = pd.merge(books, orders, left_on='book_id', right_on='book_id', how='left')

    # Filter books with no orders or all orders are processed (quantity = 0)
    no_available_books = books[
        ~books['book_id'].isin(orders[orders['quantity'] > 0]['book_id'])
    ]

    # Select required columns and sort
    result = no_available_books[['book_id', 'name']].sort_values(by='book_id')

    return result