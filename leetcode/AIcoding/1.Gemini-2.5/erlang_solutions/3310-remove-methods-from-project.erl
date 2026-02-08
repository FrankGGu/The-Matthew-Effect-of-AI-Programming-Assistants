-module(solution).
-export([removeMethodsFromProject/2]).

removeMethodsFromProject(Project, Methods) ->
    lists:map(fun(FileContent) ->
        lists:foldl(fun(MethodName, CurrentContent) ->
            % Construct the regex pattern for the current method.
            % This pattern aims to match an entire method definition block
            % based on the method name, while adhering to the specified rules.
            %
            % (?s)               - Dotall mode: '.' matches newlines as well. Essential for multi-line method bodies.
            % (?:\\b\\w+\\b\\s+)* - Matches zero or more method modifiers or return types (e.g., "public static void ").
            %                      \\b\\w+\\b matches a whole word (identifier), \\s+ matches one or more whitespaces.
            % (?<!\\.)           - Negative lookbehind assertion: ensures the method name is NOT preceded by a dot.
            %                      This prevents removing method calls like 'obj.methodName()'.
            % \\b" ++ MethodName ++ "\\b - Matches the specific MethodName as a whole word (using word boundaries \\b).
            % \\s*               - Matches zero or more whitespace characters.
            % \\(                - Matches a literal opening parenthesis.
            % [^)]*              - Matches any character except a closing parenthesis, zero or more times.
            %                      This captures the method parameters.
            % \\)                - Matches a literal closing parenthesis.
            % \\s*               - Matches zero or more whitespace characters.
            % \\{                - Matches a literal opening curly brace.
            % [^}]*?             - Matches any character except a closing curly brace, zero or more times, NON-GREEDILY.
            %                      This attempts to capture the method body up to its first closing brace.
            %                      Note: This is a simplification and might not correctly handle deeply nested braces
            %                      within the method body. For LeetCode-style problems, this is often sufficient.
            % \\}                - Matches a literal closing curly brace.
            Pattern = "(?s)(?:\\b\\w+\\b\\s+)*(?<!\\.)\\b" ++ MethodName ++ "\\b\\s*\\([^)]*\\)\\s*\\{[^}]*?\\}",
            re:replace(CurrentContent, Pattern, "", [global, {return, list}])
        end, FileContent, Methods)
    end, Project).