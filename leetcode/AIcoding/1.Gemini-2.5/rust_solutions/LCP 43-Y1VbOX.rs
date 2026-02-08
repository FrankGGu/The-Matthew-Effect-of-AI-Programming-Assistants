struct Solution;

impl Solution {
    pub fn traffic_at_crossroads() -> String {
        r#"
SELECT
    d.crossroads_id,
    COALESCE(ROUND(AVG(t.duration), 2), 0.00) AS average_travel_time
FROM
    Drivers d
LEFT JOIN
    Trips t ON d.driver_id = t.driver_id AND t.start_time = '2021-01-01'
GROUP BY
    d.crossroads_id
ORDER BY
    d.crossroads_id;
        "#.to_string()
    }
}