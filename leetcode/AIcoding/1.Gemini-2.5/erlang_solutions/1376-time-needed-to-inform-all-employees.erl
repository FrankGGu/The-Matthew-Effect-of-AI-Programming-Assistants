-module(solution).
-export([numTimesNeeded/4]).

numTimesNeeded(N, HeadID, ManagerList, InformTimeList) ->
    % 1. Build ReportsMap: A map where ManagerID -> [ReportIDs]
    % ManagerList is 0-indexed, so we iterate from 0 to N-1
    ReportsMap = build_reports_map(N, ManagerList, maps:new()),

    % 2. Convert InformTimeList to an array for O(1) access
    InformTimeArray = array:from_list(InformTimeList),

    % 3. Start DFS from HeadID with initial accumulated time 0
    dfs(HeadID, 0, ReportsMap, InformTimeArray).

build_reports_map(N, ManagerList, AccMap) ->
    build_reports_map(0, N, ManagerList, AccMap).

build_reports_map(I, N, ManagerList, AccMap) when I < N ->
    % lists:nth is 1-indexed, so we use I + 1 for 0-indexed ManagerList
    ManagerID = lists:nth(I + 1, ManagerList),
    case ManagerID of
        -1 -> % HeadID's manager is -1, skip
            build_reports_map(I + 1, N, ManagerList, AccMap);
        _ ->
            % Update the map: if ManagerID exists, prepend I to its list of reports;
            % otherwise, create a new list [I] for ManagerID.
            NewAccMap = maps:update_with(ManagerID, fun(Reports) -> [I | Reports] end, [I], AccMap),
            build_reports_map(I + 1, N, ManagerList, NewAccMap)
    end;
build_reports_map(_I, _N, _ManagerList, AccMap) ->
    AccMap.

dfs(CurrentEmployee, AccumulatedTimeSoFar, ReportsMap, InformTimeArray) ->
    % Get the list of direct reports for CurrentEmployee, default to empty list if none
    Reports = maps:get(CurrentEmployee, ReportsMap, []),

    case Reports of
        [] -> % If CurrentEmployee has no reports (is a leaf node)
            % The time to inform this leaf is the accumulated time to reach it
            AccumulatedTimeSoFar;
        _ -> % If CurrentEmployee has reports (is a manager)
            % Get the time it takes for CurrentEmployee to inform its direct reports
            ManagerInformTime = array:get(CurrentEmployee, InformTimeArray),

            % Recursively call dfs for each report, adding ManagerInformTime
            % to the accumulated time for the path to that report.
            TimesForReports = [dfs(Report, AccumulatedTimeSoFar + ManagerInformTime, ReportsMap, InformTimeArray) || Report <- Reports],

            % The maximum time for this subtree is the maximum of the times
            % returned by its reports' subtrees.
            lists:max(TimesForReports)
    end.