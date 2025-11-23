class Solution:
    def pivotTable(self, data: list[list[any]], pivot_column: str, value_column: str) -> list[list[any]]:
        if not data or len(data) == 1:
            headers = data[0] if data else []
            index_col_names = [col for col in headers if col != pivot_column and col != value_column]
            return [index_col_names] if index_col_names else []

        headers = data[0]
        records = data[1:]

        pivot_col_idx = headers.index(pivot_column)
        value_col_idx = headers.index(value_column)

        index_col_indices = [i for i, col_name in enumerate(headers) if col_name != pivot_column and col_name != value_column]
        index_col_names = [headers[i] for i in index_col_indices]

        unique_pivot_values = set()
        index_to_row_data = {}

        for record in records:
            pivot_val = record[pivot_col_idx]
            value_val = record[value_col_idx]
            index_key = tuple(record[i] for i in index_col_indices)

            unique_pivot_values.add(pivot_val)

            if index_key not in index_to_row_data:
                index_to_row_data[index_key] = {}
            index_to_row_data[index_key][pivot_val] = value_val

        sorted_pivot_values = sorted(list(unique_pivot_values))

        new_headers = index_col_names + sorted_pivot_values
        new_rows = []

        for index_key in sorted(index_to_row_data.keys()):
            row_data = index_to_row_data[index_key]
            current_row = list(index_key)
            for pv in sorted_pivot_values:
                current_row.append(row_data.get(pv, None))
            new_rows.append(current_row)

        return [new_headers] + new_rows