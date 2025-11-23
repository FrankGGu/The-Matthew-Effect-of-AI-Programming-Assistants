SELECT user_id, COUNT(*) AS post_count
FROM Posts
GROUP BY user_id
HAVING post_count > 1
ORDER BY post_count DESC, user_id ASC;