class Solution {
    solve(arr) {
        return arr.map(row => {
            row['new_column'] = row['old_column'] * 2;
            return row;
        });
    }
}