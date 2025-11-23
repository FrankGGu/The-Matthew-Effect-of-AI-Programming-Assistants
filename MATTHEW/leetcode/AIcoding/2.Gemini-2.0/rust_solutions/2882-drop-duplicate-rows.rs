use std::collections::HashSet;
use polars::prelude::*;

fn drop_duplicate_rows(df: DataFrame) -> DataFrame {
    let mut seen: HashSet<Vec<Option<String>>> = HashSet::new();
    let mut result: Vec<Series> = Vec::new();
    let mut indices: Vec<usize> = Vec::new();

    for i in 0..df.height() {
        let mut row: Vec<Option<String>> = Vec::new();
        for col in df.get_columns() {
            let val = match col.get(i) {
                AnyValue::Null => None,
                AnyValue::String(s) => Some(s.to_string()),
                AnyValue::Utf8(s) => Some(s.to_string()),
                AnyValue::Boolean(b) => Some(b.to_string()),
                AnyValue::Int8(n) => Some(n.to_string()),
                AnyValue::Int16(n) => Some(n.to_string()),
                AnyValue::Int32(n) => Some(n.to_string()),
                AnyValue::Int64(n) => Some(n.to_string()),
                AnyValue::UInt8(n) => Some(n.to_string()),
                AnyValue::UInt16(n) => Some(n.to_string()),
                AnyValue::UInt32(n) => Some(n.to_string()),
                AnyValue::UInt64(n) => Some(n.to_string()),
                AnyValue::Float32(n) => Some(n.to_string()),
                AnyValue::Float64(n) => Some(n.to_string()),
                _ => Some(format!("{:?}", col.get(i))),
            };
            row.push(val);
        }

        if !seen.contains(&row) {
            seen.insert(row);
            indices.push(i);
        }
    }

    for col in df.get_columns() {
        let mut builder = PrimitiveChunkedBuilder::<Int64Type>::new(col.name(), indices.len());
        for &i in &indices {
            match col.get(i) {
                AnyValue::Null => {builder.append_null()},
                AnyValue::String(s) => {builder.append_value(s.parse::<i64>().unwrap_or(0))},
                AnyValue::Utf8(s) => {builder.append_value(s.parse::<i64>().unwrap_or(0))},
                AnyValue::Boolean(b) => {builder.append_value(if b {1} else {0})},
                AnyValue::Int8(n) => {builder.append_value(n as i64)},
                AnyValue::Int16(n) => {builder.append_value(n as i64)},
                AnyValue::Int32(n) => {builder.append_value(n as i64)},
                AnyValue::Int64(n) => {builder.append_value(n as i64)},
                AnyValue::UInt8(n) => {builder.append_value(n as i64)},
                AnyValue::UInt16(n) => {builder.append_value(n as i64)},
                AnyValue::UInt32(n) => {builder.append_value(n as i64)},
                AnyValue::UInt64(n) => {builder.append_value(n as i64)},
                AnyValue::Float32(n) => {builder.append_value(n as i64)},
                AnyValue::Float64(n) => {builder.append_value(n as i64)},
                _ => {builder.append_value(0)},
            };
        }
        let ser = builder.finish().into_series();
        result.push(ser);

    }

    let mut new_df = DataFrame::new(result).unwrap();

    let original_dtypes: Vec<DataType> = df.get_columns().iter().map(|col| col.dtype().clone()).collect();
    let mut final_result: Vec<Series> = Vec::new();

    for (i,col) in new_df.get_columns().iter().enumerate() {
            let original_dtype = &original_dtypes[i];
                let new_ser = match original_dtype {
                        DataType::String => {
                            let ca = col.i64().unwrap();
                            let new_ca = ca.cast(&DataType::Utf8).unwrap();
                            new_ca
                        },
                        DataType::Utf8 => {
                            let ca = col.i64().unwrap();
                            let new_ca = ca.cast(&DataType::Utf8).unwrap();
                            new_ca
                        },
                        DataType::Boolean => {
                            let ca = col.i64().unwrap();
                            let new_ca = ca.cast(&DataType::Boolean).unwrap();
                            new_ca
                        },
                        DataType::Int8 => {
                            let ca = col.i64().unwrap();
                            let new_ca = ca.cast(&DataType::Int8).unwrap();
                            new_ca
                        },
                        DataType::Int16 => {
                            let ca = col.i64().unwrap();
                            let new_ca = ca.cast(&DataType::Int16).unwrap();
                            new_ca
                        },
                        DataType::Int32 => {
                            let ca = col.i64().unwrap();
                            let new_ca = ca.cast(&DataType::Int32).unwrap();
                            new_ca
                        },
                        DataType::Int64 => {
                            col.clone()
                        },
                        DataType::UInt8 => {
                            let ca = col.i64().unwrap();
                            let new_ca = ca.cast(&DataType::UInt8).unwrap();
                            new_ca
                        },
                        DataType::UInt16 => {
                            let ca = col.i64().unwrap();
                            let new_ca = ca.cast(&DataType::UInt16).unwrap();
                            new_ca
                        },
                        DataType::UInt32 => {
                            let ca = col.i64().unwrap();
                            let new_ca = ca.cast(&DataType::UInt32).unwrap();
                            new_ca
                        },
                        DataType::UInt64 => {
                            let ca = col.i64().unwrap();
                            let new_ca = ca.cast(&DataType::UInt64).unwrap();
                            new_ca
                        },
                        DataType::Float32 => {
                            let ca = col.i64().unwrap();
                            let new_ca = ca.cast(&DataType::Float32).unwrap();
                            new_ca
                        },
                        DataType::Float64 => {
                            let ca = col.i64().unwrap();
                            let new_ca = ca.cast(&DataType::Float64).unwrap();
                            new_ca
                        },
                        _ => {
                           col.clone()
                        }
                };
        final_result.push(new_ser);
    }

    DataFrame::new(final_result).unwrap()
}