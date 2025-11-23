import pandas as pd

def find_products(products: pd.DataFrame) -> pd.DataFrame:
    valid_serial_numbers_mask = (
        products['serial_number'].str.startswith('LT') &
        products['serial_number'].str.endswith('1A') &
        (products['serial_number'].str.len() == 9)
    )

    return products[valid_serial_numbers_mask]