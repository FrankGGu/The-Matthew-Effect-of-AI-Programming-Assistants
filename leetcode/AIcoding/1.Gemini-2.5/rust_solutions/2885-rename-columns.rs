impl Solution {
    pub fn rename_columns(table_name: String, old_column_name: String, new_column_name: String) -> String {
        format!("ALTER TABLE {} RENAME COLUMN {} TO {};", table_name, old_column_name, new_column_name)
    }
}