function dropMissingData(data) {
    return data.filter(item => item !== null && item !== undefined);
}