use polars::prelude::*;

fn drop_missing_data(df: DataFrame) -> DataFrame {
    df.drop_nulls(None)
}