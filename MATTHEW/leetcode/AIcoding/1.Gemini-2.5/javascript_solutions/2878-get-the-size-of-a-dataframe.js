var getDataFrameSize = function(df) {
    if (df.length === 0) {
        return [0, 0];
    }

    const rows = df.length;
    const columns = Object.keys(df[0]).length;

    return [rows, columns];
};