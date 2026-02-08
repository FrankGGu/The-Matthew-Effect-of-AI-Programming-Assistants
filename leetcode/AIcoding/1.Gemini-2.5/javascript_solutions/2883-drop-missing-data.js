var dropMissingData = function(data) {
    const isMissing = (value) => {
        return value === null || value === undefined || Number.isNaN(value);
    };

    return data.filter(row => {
        return !row.some(isMissing);
    });
};