package main

func assignColIndices(df *DataFrame) {
    for i := 0; i < len(df.Columns); i++ {
        df.Columns[i].Index = i
    }
}