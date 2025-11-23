-module(analyze_subscription_conversion).
-export([solve/0]).

solve() ->
  Query = "WITH
  Paying AS (
      SELECT DISTINCT user_id
      FROM Subscriptions
      WHERE subscription_type = 'Paid'
  ),
  Free AS (
      SELECT DISTINCT user_id
      FROM Subscriptions
      WHERE subscription_type = 'Free'
  )
  SELECT
      CAST(COUNT(DISTINCT p.user_id) AS REAL) * 100 / (SELECT COUNT(DISTINCT user_id) FROM Free) AS conversion_rate
  FROM
      Paying p
  WHERE
      p.user_id IN (SELECT user_id FROM Free);",

  % Replace with your actual database connection and query execution logic.
  % This is a placeholder.
  % In a real LeetCode environment, you would use the provided database interface.

  io:format("~p~n", [execute_query(Query)]). % Placeholder.  Needs to return a single number.

execute_query(Query) ->
    % This is a dummy implementation. Replace with actual database interaction.
    % In a real LeetCode environment, you would use the provided database interface.

    % Example:  Let's assume the query returned a single row with a float value.
    %  You would need to parse the result from the database and return the conversion rate.

    % For now, just return a dummy conversion rate.
    50.0.