function changeDataType(df, col, type) {
    df[col] = df[col].map(value => {
        if (type === 'int') return parseInt(value, 10);
        if (type === 'float') return parseFloat(value);
        if (type === 'str') return String(value);
        return value;
    });
    return df;
}