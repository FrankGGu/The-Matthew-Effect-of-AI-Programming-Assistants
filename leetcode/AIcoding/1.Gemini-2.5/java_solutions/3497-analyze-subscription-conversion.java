SELECT
    CASE
        WHEN (SELECT COUNT(DISTINCT user_id) FROM Subscriptions) = 0 THEN 0.00
        ELSE
            ROUND(
                (SELECT COUNT(DISTINCT S.user_id) FROM Subscriptions S INNER JOIN Purchases P ON S.user_id = P.user_id) * 100.0 /
                (SELECT COUNT(DISTINCT user_id) FROM Subscriptions),
                2
            )
    END AS conversion_rate;