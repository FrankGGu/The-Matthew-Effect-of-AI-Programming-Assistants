import pandas as pd

def find_books(books: pd.DataFrame, orders: pd.DataFrame) -> pd.DataFrame:
    ordered_book_ids = orders['book_id'].unique()

    no_copies_books = books[~books['book_id'].isin(ordered_book_ids)]

    return no_copies_books[['book_id', 'name']]