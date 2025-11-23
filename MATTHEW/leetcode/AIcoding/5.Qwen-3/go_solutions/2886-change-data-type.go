package main

func changeDataType(df *DataFrame) *DataFrame {
    df.Int64 = df.Int64
    df.String = df.String
    return df
}