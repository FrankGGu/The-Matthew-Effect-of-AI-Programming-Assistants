impl Solution {
    pub fn first_day_where_you_have_been_in_all_rooms(rooms: Vec<Vec<i32>>) -> i32 {
        let n = rooms.len();
        let mut dp = vec![0; n];
        dp[0] = 0;
        let mut total = 0;

        for i in 1..n {
            dp[i] = dp[i - 1] + rooms[i - 1].len() as i32 + 1;
            total += rooms[i - 1].len() as i32;
        }

        let mut day = 0;
        while day < n && total + day < dp[day] {
            day += 1;
        }

        day
    }
}