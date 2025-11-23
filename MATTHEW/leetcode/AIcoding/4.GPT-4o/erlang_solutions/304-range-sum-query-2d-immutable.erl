%% Define the module and record for the NumMatrix
-module(num_matrix).
-compile([export_all]).

%% Define the record for the 2D matrix
-record(num_matrix, {matrix = [] :: [[integer()]]}).

%% Function to initialize the matrix
-spec num_matrix_init_(Matrix :: [[integer()]]) -> any().
num_matrix_init_(Matrix) ->
    % Store the matrix in the record
    #num_matrix{matrix = Matrix}.

%% Function to compute the sum of the region
-spec num_matrix_sum_region(Row1 :: integer(), Col1 :: integer(), Row2 :: integer(), Col2 :: integer()) -> integer().
num_matrix_sum_region(Row1, Col1, Row2, Col2) ->
    %% Get the submatrix and calculate the sum
    SubMatrix = get_submatrix(Row1, Col1, Row2, Col2),
    lists:sum(lists:flatten(SubMatrix)).

%% Function to extract the submatrix from the matrix
get_submatrix(Row1, Col1, Row2, Col2) ->
    lists:sublist(
        lists:sublist(Matrix, Row1 + 1, Row2 - Row1 + 1),
        Col1 + 1,
        Col2 - Col1 + 1
    ).

%% Example usage
%% num_matrix_init_([[3,0,1,4,2],[5,6,3,2,1],[1,2,0,1,5],[4,1,0,1,7],[1,0,3,0,5]])
%% num_matrix_sum_region(2, 1, 4, 3)
