var DataFrame = function(data, columns) {
    this.data = data;
    this.columns = columns;
};

DataFrame.prototype.size = function() {
    const rows = this.data.length;
    const cols = this.columns.length;
    return [rows, cols];
};