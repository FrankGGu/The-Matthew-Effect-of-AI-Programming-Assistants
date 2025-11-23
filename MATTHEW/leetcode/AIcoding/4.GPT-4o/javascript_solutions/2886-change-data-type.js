function changeDataType(data) {
    return data.map(item => {
        return typeof item === 'number' ? item.toString() : Number(item);
    });
}