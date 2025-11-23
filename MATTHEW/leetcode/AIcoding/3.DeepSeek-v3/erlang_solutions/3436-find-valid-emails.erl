valid_emails(SQL) ->
    "select distinct email from " ++ SQL ++ " where email regexp '^[A-Za-z][A-Za-z0-9._-]*@leetcode.com$'".