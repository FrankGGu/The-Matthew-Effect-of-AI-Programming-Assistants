-module(solution).
-export([min_wasted_space/2]).

min_wasted_space(Packages, Boxes) ->
    SortedPackages = lists:sort(Packages),
    TotalPackageSize = lists:sum(SortedPackages),
    Modulo = 1000000007,

    MinWaste = lists:foldl(
        fun(SupplierBoxesList, AccMinWaste) ->
            SortedSupplierBoxesList = lists:sort(SupplierBoxesList),

            % Convert to array for O(1) element access
            % array indices are 0-based
            SupplierBoxesArray = array:from_list(SortedSupplierBoxesList),

            {WasteForSupplier, Valid} = calculate_waste_for_supplier(SortedPackages, SupplierBoxesArray, TotalPackageSize),

            if
                Valid ->
                    min(AccMinWaste, WasteForSupplier);
                true ->
                    AccMinWaste
            end
        end,
        float:infinity(), % Use float:infinity() for initial minimum
        Boxes
    ),

    if
        MinWaste == float:infinity() ->
            -1;
        true ->
            MinWaste rem Modulo
    end.

calculate_waste_for_supplier(SortedPackages, SupplierBoxesArray, TotalPackageSize) ->
    % BoxIdx starts at 0 for array access
    calculate_waste_for_supplier_loop(SortedPackages, SupplierBoxesArray, 0, TotalPackageSize, 0).

calculate_waste_for_supplier_loop([], _SupplierBoxesArray, _BoxIdx, TotalPackageSize, CurrentSumOfChosenBoxSizes) ->
    % All packages processed, supplier is valid
    {CurrentSumOfChosenBoxSizes - TotalPackageSize, true};
calculate_waste_for_supplier_loop([PackageSize | RestPackages], SupplierBoxesArray, BoxIdx, TotalPackageSize, CurrentSumOfChosenBoxSizes) ->
    case find_fitting_box_idx(PackageSize, SupplierBoxesArray, BoxIdx) of
        {ok, NewBoxIdx, ChosenBoxSize} ->
            % Continue with the next package, using the updated box index
            calculate_waste_for_supplier_loop(RestPackages, SupplierBoxesArray, NewBoxIdx, TotalPackageSize, CurrentSumOfChosenBoxSizes + ChosenBoxSize);
        not_found ->
            % Current package cannot be packed, supplier is invalid
            {0, false} 
    end.

find_fitting_box_idx(PackageSize, SupplierBoxesArray, StartBoxIdx) ->
    LenBoxes = array:size(SupplierBoxesArray),
    find_fitting_box_idx_loop(PackageSize, SupplierBoxesArray, StartBoxIdx, LenBoxes).

find_fitting_box_idx_loop(_PackageSize, _SupplierBoxesArray, BoxIdx, LenBoxes) when BoxIdx >= LenBoxes -> 
    % BoxIdx is 0-based, so >= LenBoxes means out of bounds
    not_found;
find_fitting_box_idx_loop(PackageSize, SupplierBoxesArray, BoxIdx, LenBoxes) ->
    CurrentBoxSize = array:get(BoxIdx, SupplierBoxesArray), % 0-based array access
    if
        CurrentBoxSize >= PackageSize ->
            % Found the smallest fitting box
            {ok, BoxIdx, CurrentBoxSize};
        true ->
            % Current box is too small, try the next one
            find_fitting_box_idx_loop(PackageSize, SupplierBoxesArray, BoxIdx + 1, LenBoxes)
    end.