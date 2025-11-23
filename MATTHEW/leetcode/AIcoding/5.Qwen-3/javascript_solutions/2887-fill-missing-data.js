function fillMissingData(df) {
    for (let i = 0; i < df.length; i++) {
        if (df[i].name === null) {
            df[i].name = "Bob";
        }
    }
    return df;
}