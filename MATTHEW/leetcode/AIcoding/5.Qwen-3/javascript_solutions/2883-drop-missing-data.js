var dropMissingData = function(df) {
    return df.filter(row => row.name !== null && row.email !== null);
};